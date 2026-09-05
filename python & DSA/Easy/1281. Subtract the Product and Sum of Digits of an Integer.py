class Solution:
    def subtractProductAndSum(self, n: int) -> int:
        temp = n
        add = 0
        product = 1
        while temp > 0:
            r = temp % 10
            add  += r
            product *= r
            temp //= 10
        return product-add
        