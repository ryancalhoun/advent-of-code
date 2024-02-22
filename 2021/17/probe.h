#pragma once

class Probe
{
public:
  Probe(int dx, int dy);

  int x(int t) const;
  int y(int t) const;
  int ymax(int t) const;

protected:
  int _x;
  int _y;
  int _dx;
  int _dy;
};

