#!/bin/bash
set -e  # strict mode

show_help() {
	echo "Compile lede based nnxx firmware;

Usage: ./compile.sh [<OPTIONS>...]

OPTIONS:

       -a | --archs     SoC architectures separated by space, defaults to 'ar71xx'
       -r | --release   Optional LEDE release; if omitted will build latest master branch
       -p | --profile   Optional customizations for specific ninux communities, eg: basilicata, palermo, campania
       -w | --www       An optional directory where resulting binaries will be moved
                        If omitted binaries won't be moved from the LEDE bin directory
       -j | --jobs      Amount of parallel jobs during compilation, defaults to 1
";
}

if [ -z "$1" ]; then
	show_help
	exit 1
fi

# parse options
while [ -n "$1" ]; do
	case "$1" in
		-a|--archs) export ARCHS="$2"; shift;;
		-r|--release) export RELEASE="$2"; shift;;
		-p|--profile) export PROFILE="$2"; shift;;
		-w|--www) export WWW_DIR="$2"; shift;;
		-j|--jobs) export JOBS=$2; shift;;
		-h|--help) show_help; exit 0; shift;;
		-*)
			echo "Invalid option: $1"
			exit 1
		;;
		*) break;;
	esac
	shift;
done

RELEASE="${RELEASE:-master}"
ARCHS="${ARCHS:-ar71xx}"
JOBS=${JOBS:-1}

LEDE_DIR="lede"
LEDE_GIT="http://git.lede-project.org/source.git"
PACKAGES_BRANCH="master"

DEFAULT_FEEDS="feeds.conf.default"
CUSTOM_FEEDS="feeds.conf"
DEFAULT_CONFIG=".config.default"
CUSTOM_CONFIG=".config"

if [ -f "$CUSTOM_FEEDS" ]; then
	FEEDS=$(cat "$CUSTOM_FEEDS")
else
	FEEDS=$(cat "$DEFAULT_FEEDS")
fi
# replace <PACKAGES_BRANCH> with $PACKAGES_BRANCH
FEEDS=$(echo "${FEEDS//<PACKAGES_BRANCH>/$PACKAGES_BRANCH}")

if [ -f "$CUSTOM_CONFIG" ]; then
	CONFIG=$(cat "$CUSTOM_CONFIG")
else
	CONFIG=$(cat "$DEFAULT_CONFIG")
fi

if [ -d $LEDE_DIR ]; then
	cd $LEDE_DIR
	git pull
else
	git clone $LEDE_GIT $LEDE_DIR
	cd $LEDE_DIR
fi

if [[ "$RELEASE" != "master" ]]; then
    git reset --hard $RELEASE
fi

REVISION=$(git describe --tags --always)

# configure and update feeds
echo "$FEEDS" > feeds.conf
./scripts/feeds update -a
./scripts/feeds install -a

echo "Setting up custom files"
# cleanup files
if [ -d files ]; then
	rm -rf files
fi
# put custom files
mkdir files
cp -r ../files/* ./files
# use profile if defined
if [ -n "$PROFILE" ] && [ -d "../$PROFILE" ]; then
    cp -r "../$PROFILE" ./files
fi

for arch in $ARCHS; do
	# configure
	echo "CONFIG_TARGET_$arch=y" > .config
	echo "$CONFIG" >> .config
	make defconfig

	# compile
	make -j $JOBS
done

# publish binaries if -w|-www option is supplied
if [ -n "$WWW_DIR" ]; then
	BUILD_DIR="$WWW_DIR/lede-$RELEASE/$REVISION"
	if [ -d "$BUILD_DIR" ]; then
		rm -rf $BUILD_DIR
	fi
	mkdir -p $BUILD_DIR
	echo "Copying ./bin contents to $BUILD_DIR"
	cp -fr bin/* $BUILD_DIR
	echo "Copying .config file to $BUILD_DIR/config.txt"
	cp .config $BUILD_DIR/config.txt
	echo "Cleaning bin dir"
	rm -rf ./bin/*
	# update symbolic link to latest build
	if [ -h "$WWW_DIR/lede-$RELEASE/latest" ]; then
		rm "$WWW_DIR/lede-$RELEASE/latest"
	fi
	ln -s "$WWW_DIR/lede-$RELEASE/$REVISION" "$WWW_DIR/lede-$RELEASE/latest"
fi
