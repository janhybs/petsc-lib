# Simple makefile for building and packaging project Petsc

# build type
BUILD_TYPE = debug
# default location for building
BUILD_TREE = build_tree
# given by docker -v option
PACKAGE_DIR = /packages/PETSC_3.6.1_$(BUILD_TYPE)/



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
	mkdir -p $(PACKAGE_DIR)
	cp $(BUILD_TREE)/PETSC_3.6.1.deb 	$(PACKAGE_DIR)/PETSC_3.6.1.deb
	cp $(BUILD_TREE)/PETSC_3.6.1.tar.gz $(PACKAGE_DIR)/PETSC_3.6.1.tar.gz
	cp $(BUILD_TREE)/PETSC_3.6.1.zip 	$(PACKAGE_DIR)/PETSC_3.6.1.zip
.PHONY : package


clean:
	rm -rf $(BUILD_TREE)
.PHONY : clean