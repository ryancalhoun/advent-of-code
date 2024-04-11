#pragma once

class Die
{
public:
  Die();

  int roll(int n);
  int times() const;

protected:
  int _val;
};
