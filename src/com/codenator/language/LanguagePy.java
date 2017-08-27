package com.codenator.language;

import com.codenator.file.SourceFile;
import com.codenator.publicString.PublicString;

import java.util.logging.SocketHandler;

/**
 * Created by zhf on 2016/8/6.
 */
public class LanguagePy implements Language {
    private String languageName="python";
    private String runCommand;

    @Override
    public String getLanguage(){
        return languageName;
    }

    @Override
    public String getRunCommand(String fileParentPath,String noExtensionName,String extensionName){
        runCommand="chmod 755 "+fileParentPath+";"+"cd "+fileParentPath+";"+"chmod 755 "+noExtensionName+"."+extensionName+";";
        runCommand+="python -u "+noExtensionName+"."+extensionName+";";
        return runCommand;
    }
}
