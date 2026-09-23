class Solution:
    def lowerBound(self,nums,target):
        l = 0
        r = len(nums) - 1
        ans = len(nums)
        while l <= r:
            mid = (l+r)//2
            if nums[mid] >= target:
                ans = mid
                r = mid-1
            else:
                l = mid+1
        return ans
    def searchInsert(self, nums: list[int], target: int) -> int:
        return self.lowerBound(nums,target)