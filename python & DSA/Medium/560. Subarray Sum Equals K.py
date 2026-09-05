class Solution:
    def subarraySum(self, nums: List[int], target: int) -> int:
        count = 0
        prefix_sum = 0
        hashmap = {0: 1}

        for num in nums:
            prefix_sum += num
            if prefix_sum - target in hashmap:
                count += hashmap[prefix_sum - target]
            hashmap[prefix_sum] = hashmap.get(prefix_sum, 0) + 1
        return count