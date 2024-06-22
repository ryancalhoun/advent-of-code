#include "boss.h"

Boss::Boss(int points, int damage, int armor)
  : _points(points)
  , _damage(damage)
  , _armor(armor)
{}

bool attack(int& points, int damage, int armor)
{
  if(armor > damage)
    --points;
  else
    points -= (damage - armor);

  return points <= 0;
}

int Boss::play(int points, int damage, int armor) const
{
  int bosspoints = _points;
  for(int i = 0; ; ++i)
  {
    if(i % 2 == 0)
    {
      if(attack(bosspoints, damage, _armor))
        break;
    }
    else
    {
      if(attack(points, _damage, armor))
        break;
    }
  }

  return points - bosspoints;
}
