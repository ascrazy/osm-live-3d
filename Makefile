.PHONY: strandedkitty-planetiler refresh-tiles up

data/sources/planet.osm.pbf:
	echo "Please get the data/sources/planet.osm.pbf manually accordingly to the instruction in README.md" 
	exit 1

data/sources/water-polygons-split-3857:
	mkdir -p ./data/sources  
	wget -O ./data/sources/water.zip https://osmdata.openstreetmap.de/download/water-polygons-split-3857.zip
	unzip ./data/sources/water.zip -d ./data/sources

strandedkitty-planetiler:
	docker build . -f Dockerfile.strandedkitty-planetiler -t strandedkitty-planetiler

refresh-tiles: data/sources/planet.osm.pbf data/sources/water-polygons-split-3857 strandedkitty-planetiler
	docker run -it --rm -v ./data:/usr/bin/strandedkitty-planetiler/data strandedkitty-planetiler

up:
	docker-compose up