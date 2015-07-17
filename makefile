voc = /opt/voc/bin/voc




all:
	$(voc) -s stdin.Mod test.Mod -m


clean:
	rm -rf *.sym
	rm -rf *.o
	rm -rf *.c
	rm -rf *.h
