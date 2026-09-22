class Solution:
    def search(self, nums: list[int], target: int) -> int:
        left = 0
        right = len(nums) - 1
        while left <= right:
            mid = (left + right)//2
            if target == nums[mid]:
                return mid
            elif target > nums[mid]:
                #right
                left = mid+1
            else:
                #left
                right = mid - 1
        return -1