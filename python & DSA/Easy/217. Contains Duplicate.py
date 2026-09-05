class Solution:
    def containsDuplicate(self, nums: List[int]) -> bool:
        s=set()
        for i in nums:
            s.add(i)
        if (len(s)!=len(nums)):
            return True
        else:
            return False
        