#pragma once

#include <jni.h>
#include <string>
#include <vector>

class Instance
{
public:
  Instance(JNIEnv* env, jclass cls, jobject obj);
  ~Instance();

  unsigned short eval(const std::vector<std::string>& s);

protected:
  JNIEnv* _env;
  jobject _obj;
  jmethodID _eval;
};
