.PHONY: planetiler refresh-tiles up

data/sources/water-polygons-split-3857:
	mkdir -p ./data/sources  
	wget -O ./data/sources/water.zip https://osmdata.openstreetmap.de/download/water-polygons-split-3857.zip
	unzip ./data/sources/water.zip -d ./data/sources

planetiler:
	docker build . -f Dockerfile.planetiler -t planetiler

refresh-tiles: planetiler data/sources/water-polygons-split-3857 data/sources/planet.osm.pbf
	docker run -it --rm -v ./data:/usr/bin/strandedkitty-planetiler/data planetiler

up:
	docker-compose up