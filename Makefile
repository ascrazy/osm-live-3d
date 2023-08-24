.PHONY: strandedkitty-planetiler refresh-tiles up osmium josm-to-pbf

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

osmium:
	docker build . -f Dockerfile.osmium -t osmium

data/sources/planet.osm:
	echo "Please put your JOSM file at the data/sources/planet.osm" 
	exit 1

josm-to-pbf: osmium data/sources/planet.osm
	docker run -it --rm -v ./data:/data osmium osmium renumber /data/sources/planet.osm -o /data/sources/planet-renumbered.osm --overwrite
	docker run -it --rm -v ./data:/data osmium osmconvert /data/sources/planet-renumbered.osm -o=/data/sources/planet.osm.pbf
