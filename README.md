# duck-os
基于scheme写的os

## 使用

### 编译
```make ```

### 运行镜像

```make run```

## 文档

### 目录结构
```
boot.ss    加载loader到内存中，跳转到loader
loader.ss 加载内核到内存中，进入保护模式，跳转到内核
```

### BIOS 基本功能

#### 显示相关
INT 10h
1. 设置光标位置 
AH=02H	BH=页码，DH=列，DL=行

2. 清除屏幕
AH=06H	AL=滚动的行（0=清除，被用于CH，CL，DH，DL），
BH=背景颜色和前景颜色，BH=43H，意义为背景颜色为红色，前景颜色为青色。请参考BIOS颜色属性。
CH=高行数，CL=左列数，DH=低行数，DL=右列数

```
颜色显示
二进制数	颜色	例子	二进制数	颜色	例子
0000	黑色	black	1000	灰色	gray
0001	蓝色	blue	1001	淡蓝色	light blue
0010	绿色	green	1010	淡绿色	light green
0011	青色	cyan	1000	淡青色	light cyan
0100	红色	red	1100	淡红色	light red
0101	紫红色	magenta	1101	淡紫红色	light magenta
0110	棕色	brown	1110	黄色	yellow
0111	银色	light gray	1111	白色	white
```

#### 磁盘相关
INT 10h

1. 复位
AH	00h
DL	Drive (bit 7 set means reset both hard and floppy disks)

```
DL = 00h	1st floppy disk ( "drive A:" )
DL = 01h	2nd floppy disk ( "drive B:" )
DL = 02h	3rd floppy disk ( "drive B:" )
. . .
DL = 7Fh	128th floppy disk)
DL = 80h	1st hard disk
DL = 81h	2nd hard disk
DL = 82h	3rd hard disk
. . .
DL = E0h	CD/DVD[citation needed], or 97th hard disk
. . .
DL = FFh	128th hard disk
```

2. 读取一个扇区
AH=02h: Read Sectors From Drive
```
AH	02h
AL	Sectors To Read Count
CH	Cylinder
CL	Sector
DH	Head
DL	Drive
ES:BX	Buffer Address Pointer
Results
CF	Set On Error, Clear If No Error
AH	Return Code
AL	Actual Sectors Read Count
```




# 参考
https://en.wikipedia.org/wiki/INT_10H   
https://en.wikipedia.org/wiki/INT_13H   
https://stanislavs.org/helppc/int_13-1.html 
https://baike.baidu.com/item/INT10H/22788179?fr=aladdin 





