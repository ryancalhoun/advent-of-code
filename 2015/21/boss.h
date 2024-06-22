#pragma once

class Boss
{
public:
  Boss(int points, int damage, int armor);

  int play(int points, int damage, int armor) const;

protected:
  int _points;
  int _damage;
  int _armor;
};
