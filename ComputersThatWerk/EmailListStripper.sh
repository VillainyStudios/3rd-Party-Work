
# Some names have quotes.  There are commas, angle brackets.  We see things like:
#
# example:
# "alice"<alice@company.com>, bob <bob@organization.net>, charlotte-lynne daniels<cld@provider.com>

# Input string.  This is likely long
str=''

# Output directory/file
outfile=''

echo $str | \
  gawk -v FPAT='<[^>]+>+' -v OFS= '{$1=$1}1' | \
  tr '>' '\n' | \
  sed 's/<//' \
  > $outfile
