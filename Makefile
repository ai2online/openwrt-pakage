##############################################
   #OpenWrt的HelloWorld程序文件
   #
   #
   #大多数这里使用的变量的定义
   #将包括以下指令。我们只需要
   #指定包的基本描述，
   #在哪里建立我们的计划，在哪里可以找到
   #源文件，并在哪里安装
   #编译的程序在路由器上。
   #
   #要非常小心间距在这个文件中。
   #缩进应该是制表符，而不是空格，
   #没有结尾的空格。
   ##############################################
   include $(TOPDIR)/rules.mk
   #名字和版本
   PKG_NAME:=helloworld
   PKG_RELEASE:=1
   #这里指定的地方，我们要构建的程序的目录。
   #建立根目录是$（BUILD_DIR），默认情况下是build_mipsel
   #在OpenWrt的SDK目录下
   PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)
   include $(INCLUDE_DIR)/package.mk
   #指定该程序包的信息。
   #这里定义的变量应该解释自己的作用。
   #如果你运行的是Kamikaze，删除描述下面变量并取消了Kamikaze定义，
   #指令进行以下的说明
   define Package/helloworld
            SECTION:=utils
            CATEGORY:=Utilities
            TITLE:=Helloworld -- prints a snarky message
   endef
   #取消下面的Kamikaze部分，并删除上面的描述
   define Package/helloworld/description
        If you can't figure out what this program does, you're probably
        brain-dead and need immediate medical attention.
   endef
   #指定哪些需要做，为构建软件包做好准备。
   #在我们的例子中，我们需要将源文件复制到构建目录。
   #这不是默认设置。在默认情况下使用PKG_SOURCE_URL
   #这不是定义为从网络下载的源代码PKG_SOURCE。
   define Build/Prepare
         mkdir -p $(PKG_BUILD_DIR)
         $(CP) ./src/* $(PKG_BUILD_DIR)/
   endef
   #我们并不需要定义构建/配置或编译/编译指令
   #默认值是合适的编译一个简单的程序，像这样的
   #指定在何处以及如何安装该程序。因为我们只有一个文件，
   #将HelloWorld可执行文件，通过它复制到/bin目录安装到
   #路由器。$(1)变量表示在路由器运行的目录
   #OpenWrt.$(INSTALL_DIR)变量包含一个命令来准备安装
   #目录，如果它不存在。同样$（INSTALL_BIN）包含
   #命令将二进制文件从当前位置复制（在我们的案例中构建
   #的目录）安装目录
   define Package/helloworld/install
       $(INSTALL_DIR) $(1)/bin
       $(INSTALL_BIN) $(PKG_BUILD_DIR)/helloworld $(1)/bin/
   endef
   #这一行执行必要的命令来编译我们的程序。
   #以上定义指令指定所有需要的信息，但是这
   #行调用BuildPackage从而实际上使用该信息来
   #创建一个软件包。
   $(eval $(call BuildPackage,helloworld))  
