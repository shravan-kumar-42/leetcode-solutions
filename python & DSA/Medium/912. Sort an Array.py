'''
#Bubble Sort
class Solution:
    def sortArray(self, nums: list[int]) -> list[int]:
        n = len(nums)
        for i in range(n):
            isswap = False
            for j in range(n-i-1):
                if nums[j] > nums[j+1]:
                    temp = nums[j]
                    nums[j] = nums[j+1]
                    nums[j+1] = temp
                    isswap = True
            if not isswap:
                break
        return nums
'''


#Heap Sort
class Solution:
    def sortArray(self, nums: list[int]) -> list[int]:

        n = len(nums)

        def heapify(n, i):
            largest = i
            left = 2 * i + 1
            right = 2 * i + 2

            if left < n and nums[left] > nums[largest]:
                largest = left

            if right < n and nums[right] > nums[largest]:
                largest = right

            if largest != i:
                nums[i], nums[largest] = nums[largest], nums[i]
                heapify(n, largest)

        # Build max heap
        for i in range(n // 2 - 1, -1, -1):
            heapify(n, i)

        # Extract elements one by one
        for i in range(n - 1, 0, -1):
            nums[0], nums[i] = nums[i], nums[0]
            heapify(i, 0)

        return nums