iptap is an out of the box network interface for integrated circuits. Featuring tcp connection handling over ethernet.

### setup ###
The following files are required to use iptap in your project.

- crc32.vhd
- ethernet_adapter.vhd
- etherx.vhd
- ethetx.vhd
- instruction_mem.vhd
- ipchecksum.vhd
- iptap.vhd
- LogicInterface.vhd
- trigger.sch
- pblaze/kcpsm3.vhd

The interface for iptap is declared as:
`

	COMPONENT iptap
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;

		E_RXD : IN std_logic_vector(3 downto 0);
		E_RX_DV : IN std_logic;
		E_RX_CLK : IN std_logic;
		E_TX_CLK : IN std_logic;
		E_NRST : OUT std_logic;
		E_TXD : OUT std_logic_vector(3 downto 0);
		E_TX_EN : OUT std_logic;

		L_DATA_IN : IN std_logic_vector(7 downto 0);
		L_ACK, L_DATA_VALID : IN std_logic;          
		L_ADDR : OUT std_logic_vector(31 downto 0);
		L_DATA_OUT : OUT std_logic_vector(7 downto 0);
		L_WE : OUT std_logic;
		L_RE : OUT std_logic
		);
	END COMPONENT;

Where clk is your clock signal and rst is your reset signal. Signals beginning with E_ should be connected to your ethernet phy.

#### IP setup ####
The IP is configured to 10.0.0.2 and should be changed to fit your network subnet. This can be done by changing ipstack.psm on line 76 to 79. Note that you need to reassemble ipstack.psm using "asm.bat ipstack.psm" after any change. Alternatively you may also patch instruction_mem.vhd directly to reflect your settings.

Netmask, Gateway and ARP is not required since iptap directly responds to incoming packets using packet source MAC and IP address.  

### iptap command line utility ###
The iptap command line utility is a very basic netcat like communication tool. Used to send and receive files or streams through iptap.

	iptap <host> put <hex address> [input file]
    iptap <host> get <hex address> <size> [output file]

stdin or stdout is used if no file is specified.

### send protocol ###
Sending data to your ic is done by connecting to tcp port 81, send the 4 byte start address, followed by any amount of data. Like any data interpreted by iptap, the address is interpreted as big endian binary.

1. net: establish connection to tcp port 81
2. net: send 4 byte begin address in big endian
3. log: the begin address is loaded into L_ADDR
3. net: send more data using the established connection
4. log: L\_DATA\_OUT contains valid data and L_WE (write enable) will go high until every byte has been acknowledged
5. log: for each L_ACK, L_ADDR is incremented until each byte has been read.
6. repeat step 3 until tcp connection close or connection timeout

Note that every idle connection gets terminated after 2-5 seconds to prevent deadlocks.

### receive protocol ###
Fetching data from the ic is done by connecting to tcp port 82, send the 4 byte start address and 2 byte length to fetch. Iptap will close the connection immediately after successful transfer.

1. net: establish connection to tcp port 82
2. net: send 4 byte begin address and 2 byte length in big endian
3. log: the begin address is loaded into L_ADDR
4. log: L_RE (read enable) is asserted and must be acknowledged for every read address.
5. log: the ic sets L\_DATA\_IN and asserts L\_DATA\_VALID for each byte requested. Note, the last byte should be send no more than 64 cycles after the last L\_ACK assertion.
6. net: connection close by iptap

Note the get protocol is limited to 1024 bytes per connection. Any larger length may result in unpredicted behaviour.

### beacon protocol ###
The controller sends periodical udp broadcasts on port 4097. Containing 2 magic bytes 'H' 'U' followed by one version byte (currently 0) and one message type byte (0 for beacons). Beacons are send every 2 to 5 seconds depending on network traffic and only if no connection has been established.

### ping ###
Iptap responds to ICMP echo requests (ping) sent to it's unicast address.

### development state ###
Iptap has been tested on Sparten 3 AN/E Starter Kits using ISE 14.7 for synthesis.

### contact ###
Iptap is a semester project done by Michael Offel at Humboldt University Berlin. For questions and contributions please contact mio at mflour dot com.