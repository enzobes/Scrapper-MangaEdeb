function checkDir() {
	dir2=$1
	if [ ! -d "$dir2" ]; then
		mkdir $dir2
	else
		echo "dir $dir2 già esistente"
	fi
}
