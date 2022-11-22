all: BootLoader Disk.img

# 00.BootLoader 내부의 makefile 을 실행 
BootLoader:
	@echo
	@echo ============== Biild Boot Loader ==============
	@echo
	make -C 00.BootLoader
	@echo
	@echo ============== Build Complete ==============
	@echo

# 00.BootLoader/BootLoader.bin 파일을 Disk.img 로 복사
Disk.img: 00.BootLoader/BootLoader.bin
	@echo
	@echo ==============Disk Image Build Start ==============
	@echo
	cp 00.BootLoader/BootLoader.bin Disk.img
	@echo
	@echo ============== All Build Complete ==============
	@echo

# 각 makefile 의 clean 옵션을 실행, Disk.img 삭제
clean:
	make -C 00.BootLoader clean
	rm -f Disk.img
