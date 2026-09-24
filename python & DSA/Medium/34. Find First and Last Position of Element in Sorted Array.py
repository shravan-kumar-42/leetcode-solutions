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
    def upperBound(self,nums,target):
        l = 0
        r = len(nums) - 1
        ans = len(nums)
        while l <= r:
            mid = (l+r)//2
            if nums[mid] > target:
                ans = mid
                r = mid-1
            else:
                l = mid+1
        return ans 
    def searchRange(self, nums: list[int], target: int) -> list[int]:
        lb = self.lowerBound(nums,target)
        ub = self.upperBound(nums,target)
        if lb == ub:
            return (-1,-1)
        else:
            return (lb,ub-1) 