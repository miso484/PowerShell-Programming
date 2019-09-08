#
# $psUnsupportedConsoleApplications
#

# List the unsupported commands
$psUnsupportedConsoleApplications

# Add a command to this list
$psUnsupportedConsoleApplications.Add('Mycommand')

# Show the augmented list of commands
$psUnsupportedConsoleApplications

#
# $psLocalHelp
#

# See the local help map
$psLocalHelp | Format-List

$psLocalHelp.Add("get-myNoun", "c:\MyFolder\MyHelpChm.chm::/html/0198854a-1298-57ae-aa0c-87b5e5a84712.htm")

#
# $psOnlineHelp
#

$psOnlineHelp | Format-List

$psOnlineHelp.Add("get-myNoun", "http://www.mydomain.com/MyNoun.html")