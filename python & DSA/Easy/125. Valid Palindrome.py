class Solution:
    def isAlphanumeric(self,s):
        x = ord(s)
        if 97 <= x <= 122 or 65 <= x <= 90 or 48 <= x <= 57:
            return True
        return False 

    def isPalindrome(self, s: str) -> bool:
        S = s.lower()
        i = 0
        j = len(S)-1
        while i < j:
            if not self.isAlphanumeric(S[i]):
                i += 1
            elif not self.isAlphanumeric(S[j]):
                j -= 1
            elif S[i] != S[j]:
                return False
            else:
                i += 1
                j -= 1
        return True