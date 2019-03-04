MANGANAME=$1
CHAPTER=$2
baseDir=/home/Scrapper-MangaEdeb
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
       mkdir -p data
       wget -nc $URL_JSON -O data/manga.json
fi

echo "SCRAPPER FOR MANGAEDEN BY CHAPTER" 
echo "---------------------------------"
echo "Downloading: $MANGANAME"
echo "---------------------------------"

dirManga=$currDir/$MANGANAME
mkdir -p $MANGANAME
#cd $dirManga


mangaeden_link="https://www.mangaeden.com/en/en-manga/$MANGANAME/$2/1"

echo $mangaeden_link

manga=$(cat data/manga.json | jq -r '.manga[]' | grep $MANGANAME -A 15 | grep '"i"' | tr -d '",')

a=($manga)
id_manga=(${a[1]})

chapter_link_api="https://www.mangaeden.com/api/manga/$id_manga/"


if [ ! -f /home/Scrapper-MangaEden/data/$MANGANAME/chapters.json ]; then
       echo "Data JSON not found"
       echo "Downloading..."
       mkdir -p data/$MANGANAME
       wget -nc $chapter_link_api -O data/$MANGANAME/chapters.json
fi

total_chapters=$(cat data/$MANGANAME/chapters.json | jq -r '.chapters[0]' | head -2 | grep ',' | tr -d ",")
#echo $total_chapters
nb_chap_choose=$((total_chapters-CHAPTER-1))
#echo $CHAPTER
echo "---------------------------------"
echo "DOWNLOAD CHAPTER:" $CHAPTER
echo "---------------------------------"
echo "Chapter in JSON Array : "$nb_chap_choose

chapter_id=$(cat data/$MANGANAME/chapters.json | jq -r '.chapters['$nb_chap_choose']')
#echo $chapter_id
id_chapter=$( cat data/$MANGANAME/chapters.json | jq -r '.chapters['$nb_chap_choose']' | tail -2 | tr -d '"] ')

#echo $id_chapter

chapter_link_api="https://www.mangaeden.com/api/chapter/$id_chapter"
echo $chapter_link_api

#TODO: AJOUTER EXCEPTIONS SI LE CHAPITRE N'EXISTE PAS 
