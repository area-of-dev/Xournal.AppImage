SOURCE="https://github.com/xournalpp/xournalpp/releases/download/1.0.18/xournalpp-1.0.18-Debian-buster-x86_64.tar.gz"
OUTPUT="Xournal.AppImage"

all:
	echo "Building: $(OUTPUT)"
	rm -f ./$(OUTPUT)
	mkdir -p ./build


	wget --output-document=build.tar.gz --continue $(SOURCE)
	tar -zxvf build.tar.gz -C ./build

	wget --output-document=build.rpm https://rpms.remirepo.net/enterprise/7/remi/x86_64/libzip-last-1.1.3-1.el7.remi.x86_64.rpm
	rpm2cpio build.rpm | cpio -idmv

	wget --output-document=build.rpm https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/p/portaudio-19-16.el7.x86_64.rpm
	rpm2cpio build.rpm | cpio -idmv

	wget --output-document=build.rpm https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/p/portaudio-19-16.el7.x86_64.rpm
	rpm2cpio build.rpm | cpio -idmv

	wget --output-document=build.rpm https://ftp.lysator.liu.se/pub/opensuse/distribution/leap/15.2/repo/oss/x86_64/liblua5_3-5-5.3.4-lp152.4.112.x86_64.rpm
	rpm2cpio build.rpm | cpio -idmv

	wget --output-document=build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/compat-poppler022-glib-0.22.5-4.el7.x86_64.rpm
	rpm2cpio build.rpm | cpio -idmv

	wget --output-document=build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/compat-poppler022-0.22.5-4.el7.x86_64.rpm
	rpm2cpio build.rpm | cpio -idmv


	mkdir -p AppDir/application
	mkdir -p AppDir/share
	mkdir -p AppDir/lib

	cp -r build/xournalpp-1.0.18-Debian-buster-x86_64/bin/* ./AppDir/application
	cp -r build/xournalpp-1.0.18-Debian-buster-x86_64/share/* ./AppDir/share
	cp -r ./usr/lib64/* ./AppDir/lib


	chmod +x AppDir/AppRun
	export ARCH=x86_64 && ./bin/appimagetool.AppImage AppDir $(OUTPUT)
	chmod +x $(OUTPUT)

	rm -rf *.rpm *.deb *.tar.gz *.zip
	rm -rf ./build
	rm -rf ./usr
	rm -rf ./AppDir/application
	rm -rf ./AppDir/share
	rm -rf ./AppDir/lib
	rm -rf ./AppDir/share
