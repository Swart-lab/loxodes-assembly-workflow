Additional software dependencies
================================

Additional depedencies to be installed in the `opt/` folder.

# Kent utils
accessed 2019-04-11
```
mkdir -p kentutils
rsync -azvP rsync://hgdownload.soe.ucsc.edu/genome/admin/exe/linux.x86_64/ ./kentutils/
```

# FRC_align
accessed 2019-04-26
```
git clone https://github.com/vezzi/FRC_align.git
```

# HiSat2
```
wget http://ccb.jhu.edu/software/hisat2/downloads/hisat2-2.0.0-beta-source.zip
```

# Mummer4
```
wget https://github.com/mummer4/mummer/releases/download/v4.0.0beta2/mummer-4.0.0beta2.tar.gz
```

# Bandage
Using statically linked version as there is some issue with Qt libraries
```
wget https://github.com/rrwick/Bandage/releases/download/v0.8.1/Bandage_Ubuntu_static_v0_8_1.zip
```

# OpenJDK 11
```
wget https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.7%2B10/OpenJDK11U-jdk_x64_linux_hotspot_11.0.7_10.tar.gz
```

# InterProScan
```
wget ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/5.44-79.0/interproscan-5.44-79.0-64-bit.tar.gz
```

# ParaFly
```
wget http://downloads.sourceforge.net/project/parafly/parafly-r2013-01-21.tgz
```