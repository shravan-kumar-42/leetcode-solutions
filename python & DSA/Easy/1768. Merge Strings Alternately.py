class Solution:
    def mergeAlternately(self, a: str, b: str) -> str:
        c = ""
        i = 0

        while i < len(a) and i < len(b):
            c = c + a[i] + b[i]
            i += 1

        c = c + a[i:]
        c = c + b[i:]

        return c

        