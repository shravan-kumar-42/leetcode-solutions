class Solution:
    def runningSum(self, nums: List[int]) -> List[int]:
        pref = [0 for i in range(len(nums))]
        sum = 0
        for i in range(len(nums)):
            sum = sum + nums[i]
            pref[i] = sum
        return pref
        