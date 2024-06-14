#pragma once

#include <string>
#include <jni.h>

class String
{
public:
  String(JNIEnv* env, const std::string& s);
  ~String();

  jstring operator*();

protected:
  JNIEnv* _env;
  std::string _s;
  jstring _js;
};
