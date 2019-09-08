#
# Listing Printer Connections
#

# Using WMI Win32_Printer class
Get-WmiObject -Class Win32_Printer

# Using the WScript.Network COM object that is typically used in WSH scripts
(New-Object -ComObject WScript.Network).EnumPrinterConnections()

#
# Adding a Network Printer
#

(New-Object -ComObject WScript.Network).AddWindowsPrinterConnection("\\Printserver01\Xerox5")

#
# Setting a Default Printer
#

(Get-WmiObject -ComputerName . -Class Win32_Printer -Filter "Name='HP LaserJet 5Si'").SetDefaultPrinter()

(New-Object -ComObject WScript.Network).SetDefaultPrinter('HP LaserJet 5Si')

#
# Removing a Printer Connection
#

(New-Object -ComObject WScript.Network).RemovePrinterConnection("\\Printserver01\Xerox5")