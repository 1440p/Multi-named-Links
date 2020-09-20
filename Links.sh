#!/bin/bash
cd /

#
# Make Directories then Files
# cd /; mkdir /A; mkdir /B; touch /A/X; touch /B/Y

# Remove Files then Directories
# cd /; rm /B/Y; rm /A/X; rmdir /B; rmdir /A
#

# Question 1
# ln /B/Y /A/New
# The directory entries for both file names point to the same i-node. Prove it
# Make sure a hardlink is  set before attempting this
cd /; mkdir /A; mkdir /B; touch /A/X; touch /B/Y
ln /B/Y /A/New
echo ""; echo "$ ls -i /B/Y /A/New; find -inum 1703938"
echo ""; ls -i /B/Y /A/New; echo ""; find -inum 1703938; echo ""

# Question 2 & 3
# The file has only one owner (the one who created the file initially.) Prove it
echo "$ ls -l /B/Y /A/New"
echo ""; ls -l /B/Y /A/New; echo ""

# Question 3
# The file has one date last access (the last access by any on its names), one set premissions, one... . Prove it
# Note the usage: "the file nameS" (plural) vs "the file" (singular).
echo "$ stat /B/Y /A/New"
echo ""; stat /B/Y /A/New; echo ""
rm /A/New
cd /; rm /B/Y; rm /A/X; rmdir /B; rmdir /A

# Question 4
# ln -s /B/Y /A/New
# We now have an additional file /A/New, which is a symlink to /B/Y. The Number of files in the system has gone up by 1: Prove it.
# Before answering with command line, rm /A/New , then run multiple commands below
cd /; mkdir /A; mkdir /B; touch /A/X; touch /B/Y
echo ""; df -i; echo ""; df -i /dev/sda1; ln -s /B/Y /A/New; printf "\n$ ln -s /B/Y /A/New\n\n"; df -i; echo ""; df -i /dev/sda1; echo ""


# Question 5
# The file named /A/New has the name /B/Y as its data (not metadata). Prove it
echo "$ ls -l /A/New"; echo ""; ls -l /A/New; echo ""
echo "$ file /A/New"; echo ""; file /A/New; echo ""

# Question 6
# The system notices that /A/New is a red diamond (symlink) so reading /A/New will return the contents of /B/Y (assuming the reader has read permission for /B/Y).
# It is also possible to read the contents of /A/New itself (those contents are the string "/B/Y"). Prove both statements
echo "$ readlink /A/New"; echo ""; readlink /A/New; echo ""

# Question 7
# The size of A/New is 4 bytes, one for each character of its contents. Prove it
echo "$ stat /A/New"; echo ""; stat /A/New; echo ""

# Question 8
# If /B/Y is removed, /A/New becomes invalid. Show this
echo "$ rm /B/Y; cat /A/New"; echo ""; rm /B/Y; cat /A/New; echo ""

# Question 9
# If a new /B/Y is created, /A/New is once again valid. Yes, demonstrate this too
echo "$ touch /B/Y; cat /A/New"; echo ""; touch /B/Y; cat /A/New; echo ""

# Question 10
# Removing /A/New has no effect of /B/Y. is this true? why?
echo "$ ls -li /B/Y; stat /B/Y"; echo ""; ls -li /B/Y; stat /B/Y; echo ""
sleep 5
echo "$ rm /A/New"; rm /A/New; echo "";
echo "$ ls -li /B/Y; stat /B/Y"; echo ""; ls -li /B/Y; stat /B/Y; echo ""

# Question 11
# Examining /B/Y does not reveal the existence of /A/New. Prove this
echo "$ readlink /B/Y"; readlink /B/Y; echo ""

# Question 12
# If a user has write permission for /B/Y, then writing /A/New is possible and writes /B/Y. Show this
ln -s /B/Y /A/New
echo "$ echo \"karpoor\" > /A/New"; echo "karpoor" > /A/New; echo ""
echo "$ cat /B/Y"; echo ""; cat /B/Y; > /A/New; echo ""

# Question 13
# If Bob removes /B/Y and then creates another /B/Y, what happens to /A/New? Answer this question
echo "$ ls -li /A/New; stat /A/New; cat /A/New; readlink /A/New; file /A/New"; echo ""
ls -li /A/New; echo ""; stat /A/New; echo""; cat /A/New; echo ""; readlink /A/New; echo ""; file /A/New
rm /B/Y; echo "";
echo "$ ls -li /A/New; stat /A/New; cat /A/New; readlink /A/New; file /A/New"; echo "";
ls -li /A/New; echo ""; stat /A/New; echo""; cat /A/New; echo ""; readlink /A/New; echo ""; file /A/New; echo ""
touch /B/Y

# Question 14
# What about with a symlink? And this one too
echo "$ ls -li /B/Y; stat /B/Y; cat /B/Y; readlink /B/Y; file /B/Y"; echo ""
ls -li /B/Y; echo ""; stat /B/Y; echo""; cat /B/Y; echo ""; readlink /B/Y; echo ""; file /B/Y
rm /A/New; echo "";
echo "$ ls -li /B/Y; stat /B/Y; cat /B/Y; readlink /B/Y; file /B/Y"; echo ""
ls -li /B/Y; echo ""; stat /B/Y; echo""; cat /B/Y; echo ""; readlink /B/Y; echo ""; file /B/Y; echo ""
ln -s /B/Y /A/New
rm /A/New
cd /; rm /B/Y; rm /A/X; rmdir /B; rmdir /A

# Question 15
# What happens if the target of the symlink is an exisiting directory? For example, consider the code below, which gives rise to the diagram on the right.
cd /
mkdir /A; mkdir /B
touch /A/X; touch /B/Y
ln -s /B /A/New
# Answer the three questions below

# 1. Is there a file named /A/New/Y ?
echo "$ ls -li /A/New/Y; stat /A/New/Y; cat /A/New/Y; readlink /A/New/Y; file /A/New/Y"; echo ""
ls -li /A/New/Y; stat /A/New/Y; cat /A/New/Y; readlink /A/New/Y; file /A/New/Y; echo ""
echo "$ ls -li /A/New/; stat /A/New/; cat /A/New/; readlink /A/New/; file /A/New/"; echo ""
ls -li /A/New/; stat /A/New/; cat /A/New/; readlink /A/New/; file /A/New/; echo ""

# 2. What happens if you execute
#				cd /A/New followed by ls
echo "$ cd /A/New"; echo "/A/New$ ls"; echo ""
cd /A/New; ls; echo ""

# 3. What happens if you execute cd /A/New/.. Use the -L and the -P options for cd and explain your observations
cd ~
echo "~$ cd /A/New/.."
cd /A/New/..
echo "/A$ cd ~"
cd ~
echo "~$ cd -L /A/New/.."
cd -L /A/New/..
echo "/A$ cd ~"
cd ~
echo "~$ cd -P /A/New/.."
cd -P /A/New/..
echo "/$"; echo ""

rm /A/New; rm /B/Y; rm /A/X; rmdir /B; rmdir /A

# Please justify all your answers with appropriate shell commands, screen shots and other relevant proof of work!
