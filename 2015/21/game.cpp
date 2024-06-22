#define PY_SSIZE_T_CLEAN
#include <Python.h>
#include "boss.h"

static PyObject* Game_init(PyObject*, PyObject* args)
{
  Py_INCREF(Py_None);

  PyObject* self;
  int points, damage, armor;
  PyArg_ParseTuple(args, "Oiii", &self, &points, &damage, &armor);

  Boss* boss = new Boss(points, damage, armor);

  PyObject_SetAttrString(self, "boss", PyLong_FromVoidPtr(boss));

  return Py_None;
}

static PyObject* Game_play(PyObject*, PyObject* args)
{
  PyObject* self;
  int points, damage, armor;
  PyArg_ParseTuple(args, "Oiii", &self, &points, &damage, &armor);

  Boss* boss = static_cast<Boss*>(PyLong_AsVoidPtr(PyObject_GetAttrString(self, "boss")));

  //return Py_None;
  return PyLong_FromLong(boss->play(points, damage, armor));
}

static PyMethodDef class_methods[] = {
  {"__init__", Game_init, METH_VARARGS},
  {"play", Game_play, METH_VARARGS},
  {NULL, NULL, 0},
};

static PyMethodDef module_methods[] = {
  {NULL, NULL, 0, NULL},
};

static PyModuleDef def = {
  PyModuleDef_HEAD_INIT,
  "game",
  NULL,
  -1,
  module_methods,
};

PyMODINIT_FUNC PyInit_game()
{
  PyObject* mod = PyModule_Create(&def);
  PyObject* class_base = PyTuple_New(0);
  PyObject* class_dict = PyDict_New();
  PyObject* class_name = PyUnicode_FromString("Game");

  for(PyMethodDef* def = class_methods; def->ml_name; ++def)
  {
    PyObject* f = PyCFunction_New(def, NULL);
    PyObject* m = PyInstanceMethod_New(f);
    PyDict_SetItemString(class_dict, def->ml_name, m);
    Py_DECREF(f);
    Py_DECREF(m);
  }

  PyObject* class_obj = PyObject_CallFunctionObjArgs((PyObject*)&PyType_Type, class_name, class_base, class_dict, NULL);

  Py_DECREF(class_name);
  Py_DECREF(class_base);
  Py_DECREF(class_dict);

  PyModule_AddObject(mod, "Game", class_obj);

  return mod;
}

