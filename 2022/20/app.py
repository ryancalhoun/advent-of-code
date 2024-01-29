import sys
import os

def mix(nums, times):
  mixed = list(range(len(nums)))

  for t in range(times):
    for i in range(len(nums)):
      j = mixed.index(i)
      n = nums[i]

      if n == 0:
        continue

      k = (j + n) % (len(nums) - 1)

      if k == 0:
        k = len(nums) - 1

      del mixed[j]
      mixed.insert(k, i)

  return mixed

def decrypt(nums, key=1, n=1):
  for i in range(len(nums)):
    nums[i] *= key

  mixed = mix(nums, n)

  i = mixed.index(nums.index(0))
  return sum(nums[mixed[(i + j) % len(nums)]] for j in (1000, 2000, 3000))

def main():
  if os.environ.get('PART') == '1':
    print(decrypt([int(c) for c in sys.stdin]))
  else:
    print(decrypt([int(c) for c in sys.stdin], 811589153, 10))

if __name__ == '__main__':
  main()
