Welcome & Thank you. 

This is my hastily thrown together Ping Monitor that I've edited slightly to ping multiple IP Addresses (as many as you wish) at the same time. 

It "should" install automatically on any Debian based Linux system, I've tested it on 22.04 Ubuntu and 18.04 Ubuntu. Otherwise, you'll require lighttpd, Python, Flask and SQLite. 

Now, at the moment, It's set up specifically to work on my system and getting it set up is a bit of a faff.  The install.sh script will uncompress the file and set everything up for it to run as a service ONLY. 

To set up the ping file, you'll need to "systemctl stop multiping.service" and navigate to the folder "multiping" that the setup.sh created (should be in the same directory as your setup.sh script)

Then, open "app.py" in your favourite editor, I personally use nano, Notepad++ or Visual Studio Code. 

In the "class PingMonitor:" theres a line "def __init__(self, ip_addresses, interface="br0", interval=1):".  Edit "br0" in "interface="br0" to your network interface, such as enp1s0, wl0 etc. 

Next, navigate to the two lines that include the IP addresses 1.1.1.1,2.2.2.2 etc 
        ip_addresses = [{'ip': ip, 'name': ip} for ip in ['1.1.1.1', '2.2.2.2', '3.3.3.3', '4.4.4.4', '5.5.5.5', '6.6.6.6', '7.7.7.7']])
        for ip_address in ['1.1.1.1', '2.2.2.2', '3.3.3.3', '4.4.4.4', '5.5.5.5', '6.6.6.6', '7.7.7.7']:
Simply edit the IP addresses to the addresses you want to ping.  You can do as many as you like. Make sure the format follows the same pattern 'ipaddr', 'ipaddr2', etc

Make sure both of the lines are identical, but pay attention to the formatting at the end.  The first line will finish with a double square bracket, the second will finish with a square bracket and a colon. 

Lastly, navigate right to the bottom and change "app.run(host='0.0.0.0', port=8010)" where it says "port=8010" to any port you wish the service to be hosted from. 

Now simply "systemctl start multiping.service" and navigate to either http://localhost:specifiedport or from another machine or http://yourserverip:specifiedport and enjoy. 

All of the containers will originally be named with the IP address that you've asked it to ping.  You can change the name of them by clicking the address and typing a new name.  This will automatically update the database and should retain in memory.
