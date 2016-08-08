# Simple makefile for building and packaging project Petsc

BUILD_TREE = build_tree

cmake:
	mkdir -p $(BUILD_TREE)
	cd $(BUILD_TREE) && cmake ..
.PHONY : cmake


build: cmake
	cd $(BUILD_TREE) && make petsc-lib
	bash $(BUILD_TREE)/conf.sh
.PHONY : build


package:
	cd $(BUILD_TREE) && make package	
	# copy out packages
	
	cp $(BUILD_TREE)/PETSC_3.6.1.deb 	/var/www/html/packages/PETSC_3.6.1.deb
	cp $(BUILD_TREE)/PETSC_3.6.1.tar.gz /var/www/html/packages/PETSC_3.6.1.tar.gz
	cp $(BUILD_TREE)/PETSC_3.6.1.zip 	/var/www/html/packages/PETSC_3.6.1.zip
.PHONY : package


clean:
	rm -rf $(BUILD_TREE)
.PHONY : clean


# build: cmake
# 	cd $(BUILD_TREE) && make yaml-cpp
# .PHONY : build	
# 
# 
# package: build
# 	cd $(BUILD_TREE) && make package
# 	# copy out packages
# 	cp $(BUILD_TREE)/YAML_CPP_0.5.2.deb 	/var/www/html/packages/YAML_CPP_0.5.2.deb
# 	cp $(BUILD_TREE)/YAML_CPP_0.5.2.tar.gz 	/var/www/html/packages/YAML_CPP_0.5.2.tar.gz
# 	cp $(BUILD_TREE)/YAML_CPP_0.5.2.zip 	/var/www/html/packages/YAML_CPP_0.5.2.zip
# .PHONY : package