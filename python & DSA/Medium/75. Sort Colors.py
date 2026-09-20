class Solution:
    def sortColors(self, nums: list[int]) -> None:
        left = 0
        right = len(nums) -1
        i = 0
        while i <= right:
            if nums[i] == 1:
                i += 1
            elif nums[i] == 0:
                nums[i], nums[left] = nums[left], nums[i]
                i += 1
                left += 1
            else:
                nums[i], nums[right] = nums[right], nums[i]
                right -= 1
        