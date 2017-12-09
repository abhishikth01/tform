# usage one.sh
# to find symbolic links.
# -type 'l' is for symbolic link.
find . -type l >list.txt
# for loop in bash.
# here 'a' is a variable being defined.
for a in $(cat list.txt); do
# to print the content in variable 'a'
echo $a
# the remove command.
rm $a
done