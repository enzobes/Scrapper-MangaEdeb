MANGANAME=$1
CHAPTER=$2
baseDir=/home/Scrapper-MangaEden
currDir=$PWD
URL_JSON=https://www.mangaeden.com/api/list/0/

source $baseDir/functions.sh

WGET="$(which wget) -q"
if [ "WGET" = " -q" ]; then 
	echo "wget is missing. Download it before continue"
	exit 1
fi

if [ ! -f /home/Scrapper-MangaEden/data/manga.json ]; then
       echo "Data JSON not found"
       echo "Downloading..."
       mkdir data
       wget $URL_JSON -O data/manga.json
fi

echo "SCRAPPER FOR MANGAEDEN BY CHAPTER" 
echo "---------------------------------"
echo "Downloading: $MANGANAME"
echo "---------------------------------"

dirManga=$currDir/$MANGANAME

cd $dirManga


download_link="https://www.mangaeden.com/en/en-manga/$MANGANAME/$2/1"
echo $download_link

var=$(cat data/manga.json | jq -r '.manga[]' | grep $MANGANAME -A 15 | grep '"i"' | tr -d '",')

a=($var)
echo ${a[1]}

