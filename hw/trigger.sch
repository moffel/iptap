<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3a" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_1" />
        <signal name="XLXN_2" />
        <signal name="IN_D" />
        <signal name="IN_CLK" />
        <signal name="XLXN_5" />
        <signal name="XLXN_6" />
        <signal name="XLXN_7" />
        <signal name="OUT_CLK" />
        <signal name="XLXN_9" />
        <signal name="XLXN_10" />
        <signal name="OUT_D" />
        <signal name="XLXN_12" />
        <port polarity="Input" name="IN_D" />
        <port polarity="Input" name="IN_CLK" />
        <port polarity="Input" name="OUT_CLK" />
        <port polarity="Output" name="OUT_D" />
        <blockdef name="fd">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <rect width="256" x="64" y="-320" height="256" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="64" y1="-256" y2="-256" x1="0" />
            <line x2="320" y1="-256" y2="-256" x1="384" />
            <line x2="64" y1="-128" y2="-144" x1="80" />
            <line x2="80" y1="-112" y2="-128" x1="64" />
        </blockdef>
        <blockdef name="fde">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="64" y1="-192" y2="-192" x1="0" />
            <line x2="64" y1="-256" y2="-256" x1="0" />
            <line x2="320" y1="-256" y2="-256" x1="384" />
            <rect width="256" x="64" y="-320" height="256" />
            <line x2="80" y1="-112" y2="-128" x1="64" />
            <line x2="64" y1="-128" y2="-144" x1="80" />
        </blockdef>
        <blockdef name="inv">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="160" y1="-32" y2="-32" x1="224" />
            <line x2="128" y1="-64" y2="-32" x1="64" />
            <line x2="64" y1="-32" y2="0" x1="128" />
            <line x2="64" y1="0" y2="-64" x1="64" />
            <circle r="16" cx="144" cy="-32" />
        </blockdef>
        <blockdef name="xor2">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-64" x1="0" />
            <line x2="60" y1="-128" y2="-128" x1="0" />
            <line x2="208" y1="-96" y2="-96" x1="256" />
            <arc ex="44" ey="-144" sx="48" sy="-48" r="56" cx="16" cy="-96" />
            <arc ex="64" ey="-144" sx="64" sy="-48" r="56" cx="32" cy="-96" />
            <line x2="64" y1="-144" y2="-144" x1="128" />
            <line x2="64" y1="-48" y2="-48" x1="128" />
            <arc ex="128" ey="-144" sx="208" sy="-96" r="88" cx="132" cy="-56" />
            <arc ex="208" ey="-96" sx="128" sy="-48" r="88" cx="132" cy="-136" />
        </blockdef>
        <block symbolname="fde" name="XLXI_2">
            <blockpin signalname="IN_CLK" name="C" />
            <blockpin signalname="IN_D" name="CE" />
            <blockpin signalname="XLXN_2" name="D" />
            <blockpin signalname="XLXN_1" name="Q" />
        </block>
        <block symbolname="inv" name="XLXI_3">
            <blockpin signalname="XLXN_1" name="I" />
            <blockpin signalname="XLXN_2" name="O" />
        </block>
        <block symbolname="fd" name="XLXI_4">
            <blockpin signalname="OUT_CLK" name="C" />
            <blockpin signalname="XLXN_1" name="D" />
            <blockpin signalname="XLXN_10" name="Q" />
        </block>
        <block symbolname="fd" name="XLXI_5">
            <blockpin signalname="OUT_CLK" name="C" />
            <blockpin signalname="XLXN_10" name="D" />
            <blockpin signalname="XLXN_9" name="Q" />
        </block>
        <block symbolname="xor2" name="XLXI_6">
            <blockpin signalname="XLXN_9" name="I0" />
            <blockpin signalname="XLXN_10" name="I1" />
            <blockpin signalname="OUT_D" name="O" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="768" y="1248" name="XLXI_2" orien="R0" />
        <instance x="1056" y="768" name="XLXI_3" orien="M0" />
        <branch name="XLXN_1">
            <wire x2="1168" y1="736" y2="736" x1="1056" />
            <wire x2="1168" y1="736" y2="992" x1="1168" />
            <wire x2="1392" y1="992" y2="992" x1="1168" />
            <wire x2="1168" y1="992" y2="992" x1="1152" />
        </branch>
        <branch name="XLXN_2">
            <wire x2="752" y1="736" y2="992" x1="752" />
            <wire x2="768" y1="992" y2="992" x1="752" />
            <wire x2="832" y1="736" y2="736" x1="752" />
        </branch>
        <branch name="IN_D">
            <wire x2="768" y1="1056" y2="1056" x1="320" />
        </branch>
        <branch name="IN_CLK">
            <wire x2="768" y1="1120" y2="1120" x1="320" />
        </branch>
        <instance x="1392" y="1248" name="XLXI_4" orien="R0" />
        <instance x="2032" y="1248" name="XLXI_5" orien="R0" />
        <branch name="OUT_CLK">
            <wire x2="1392" y1="1120" y2="1120" x1="1376" />
            <wire x2="1376" y1="1120" y2="1392" x1="1376" />
            <wire x2="1952" y1="1392" y2="1392" x1="1376" />
            <wire x2="3088" y1="1392" y2="1392" x1="1952" />
            <wire x2="2032" y1="1120" y2="1120" x1="1952" />
            <wire x2="1952" y1="1120" y2="1392" x1="1952" />
            <wire x2="3088" y1="816" y2="1392" x1="3088" />
            <wire x2="3200" y1="816" y2="816" x1="3088" />
        </branch>
        <instance x="2560" y="752" name="XLXI_6" orien="R0" />
        <branch name="XLXN_9">
            <wire x2="2480" y1="992" y2="992" x1="2416" />
            <wire x2="2480" y1="688" y2="992" x1="2480" />
            <wire x2="2560" y1="688" y2="688" x1="2480" />
        </branch>
        <branch name="XLXN_10">
            <wire x2="1888" y1="992" y2="992" x1="1776" />
            <wire x2="2032" y1="992" y2="992" x1="1888" />
            <wire x2="2560" y1="624" y2="624" x1="1888" />
            <wire x2="1888" y1="624" y2="992" x1="1888" />
        </branch>
        <branch name="OUT_D">
            <wire x2="3088" y1="656" y2="656" x1="2816" />
            <wire x2="3200" y1="656" y2="656" x1="3088" />
        </branch>
        <iomarker fontsize="28" x="320" y="1056" name="IN_D" orien="R180" />
        <iomarker fontsize="28" x="320" y="1120" name="IN_CLK" orien="R180" />
        <iomarker fontsize="28" x="3200" y="816" name="OUT_CLK" orien="R0" />
        <iomarker fontsize="28" x="3200" y="656" name="OUT_D" orien="R0" />
    </sheet>
</drawing>