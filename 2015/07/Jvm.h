#pragma once

#include <memory>
#include <string>
#include <jni.h>

class Class;

class Jvm
{
public:
  Jvm();
  ~Jvm();

  void clear();

  std::shared_ptr<Class> loadClass(const std::string& name);

protected:
  void load();

protected:
  JavaVM* _vm;
  JNIEnv* _env;
  int _loaded;
};

