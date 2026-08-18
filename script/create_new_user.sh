#!/bin/bash

echo " Creating a new user  "

read -p "Please type in your first name: " first_name
echo "$first_name"

sudo useradd -m "$first_name"

sudo passwd "$first_name"

read -p "Please type in your department: " department


if [ getent group "$department" > /dev/null ]
then 
	echo "$department"
	sudo usermod -aG "$department" "$first_name"
	echo "$first_name has been added to $department group "

else 
	sudo groupadd "$department"
	sudo usermod -aG "$department" "$first_name"
	groups "$first_name"
	echo " $department has been created and $first_name has been added "
fi

