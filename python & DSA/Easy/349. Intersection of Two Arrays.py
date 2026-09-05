class Solution:
    def intersection(self, nums1: List[int], nums2: List[int]) -> List[int]:
        z=[]
        x=set(nums1)
        y=set(nums2)
        
        for i in x:
            if i in y:
                z.append(i)
        return z