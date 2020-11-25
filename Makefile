# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
PWD:=$(shell pwd)


OUTPUT="Xournal.AppImage"

all: clean
	mkdir --parents $(PWD)/build
	mkdir --parents $(PWD)/build/AppDir
	mkdir --parents $(PWD)/build/AppDir/lib
	mkdir --parents $(PWD)/build/AppDir/xournal
	mkdir --parents $(PWD)/build/AppDir/share



	wget --output-document=$(PWD)/build/build.tar.gz https://github.com/xournalpp/xournalpp/releases/download/1.0.19/xournalpp-1.0.19-Ubuntu-xenial-x86_64.tar.gz
	tar -zxvf $(PWD)/build/build.tar.gz -C $(PWD)/build

	wget --output-document=$(PWD)/build/build.rpm https://rpms.remirepo.net/enterprise/7/remi/x86_64/libzip-last-1.1.3-1.el7.remi.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/p/portaudio-19-16.el7.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/p/portaudio-19-16.el7.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/compat-poppler022-glib-0.22.5-4.el7.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/compat-poppler022-0.22.5-4.el7.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..
	
	wget --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/libjpeg-turbo-1.2.90-8.el7.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/openjpeg-libs-1.5.1-18.el7.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/libpng15-1.5.30-7.el8.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.deb http://ftp.br.debian.org/debian/pool/main/g/gtk+3.0/libgtk-3-0_3.24.5-1_amd64.deb
	dpkg -x $(PWD)/build/build.deb $(PWD)/build

	wget --output-document=$(PWD)/build/build.rpm https://ftp.lysator.liu.se/pub/opensuse/distribution/leap/15.2/repo/oss/x86_64/libatk-1_0-0-2.34.1-lp152.1.7.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm https://ftp.lysator.liu.se/pub/opensuse/distribution/leap/15.2/repo/oss/x86_64/libatk-bridge-2_0-0-2.34.1-lp152.1.5.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm https://ftp.lysator.liu.se/pub/opensuse/distribution/leap/15.2/repo/oss/x86_64/libatspi0-2.34.0-lp152.2.4.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.deb http://ftp.br.debian.org/debian/pool/main/l/lua5.3/liblua5.3-0_5.3.3-1.1_amd64.deb
	dpkg -x $(PWD)/build/build.deb $(PWD)/build

	wget --output-document=$(PWD)/build/build.deb http://ftp.br.debian.org/debian/pool/main/t/tiff/libtiff5_4.1.0+git191117-2~deb10u1_amd64.deb
	dpkg -x $(PWD)/build/build.deb $(PWD)/build

	wget --output-document=$(PWD)/build/build.deb http://archive.ubuntu.com/ubuntu/pool/main/libw/libwebp/libwebp6_0.6.1-2_amd64.deb
	dpkg -x $(PWD)/build/build.deb $(PWD)/build


	wget --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/jbigkit-libs-2.1-14.el8.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	cp --force --recursive $(PWD)/build/xournalpp-*/bin/* $(PWD)/build/AppDir/xournal
	cp --force --recursive $(PWD)/build/xournalpp-*/share/* $(PWD)/build/AppDir/share
	cp --force --recursive $(PWD)/build/usr/* $(PWD)/build/AppDir/
	cp --force --recursive $(PWD)/AppDir/* $(PWD)/build/AppDir

	chmod +x $(PWD)/build/AppDir/AppRun
	chmod +x $(PWD)/build/AppDir/*.desktop

	export ARCH=x86_64 && $(PWD)/bin/appimagetool.AppImage $(PWD)/build/AppDir $(PWD)/Xournal.AppImage
	chmod +x $(PWD)/Xournal.AppImage

clean:
	rm -rf $(PWD)/build
