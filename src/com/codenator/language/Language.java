package com.codenator.language;

import com.codenator.file.SourceFile;

/**
 * Created by zhf on 2016/8/1.
 */
public interface Language {
	//¿©±â ÀÖ´Â °ÍµéÀ» °¢ ¾ğ¾îÀÇ Language.java ¿¡¼­ ¿À¹ö¶óÀÌµå ÇØ°¨.
    /*?·å¾—è??è¨??ç§?
    * */
    public String getLanguage();

    /*? ¹?®æºæ–‡ä»¶sourceFile?·å¾—ä½¿?…¶è¿è¡Œ?š„?‘½ä»?
    * */
    //¿©±â
    public String getRunCommand(String fileParentPath,String noExtensionName,String extensionName);



}
