#pragma once

#include "String.h"
#include <vector>
#include <string>
#include <jni.h>

class StringArray
{
public:
  StringArray(JNIEnv* env, const std::vector<std::string>& arr);
  ~StringArray();

  jobjectArray operator*();

protected:
  JNIEnv* _env;
  std::vector<String> _arr;
  jobjectArray _jarr;
};
