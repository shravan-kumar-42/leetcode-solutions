class Solution:
    def spiralOrder(self, matrix: list[list[int]]) -> list[int]:
        n = len(matrix)
        m = len(matrix[0])

        total = n*m
        ans = []
        c = 0

        colstart = 0
        rowstart = 0
        colend = m-1
        rowend = n-1

        while c < total:
            # rowstart, colstart->colend
            for i in range(colstart,colend+1):
                ans.append(matrix[rowstart][i])
                c += 1
            rowstart += 1

            if c == total:
                break

            #colend, rowstart->rowend
            for i in range(rowstart,rowend+1):
                ans.append(matrix[i][colend])
                c += 1
            colend -= 1

            if c == total:
                break

            #rowend, colend->colstart
            for i in range(colend,colstart-1,-1):
                ans.append(matrix[rowend][i])
                c += 1
            rowend -= 1

            if c == total:
                break

            #colstart, rowend->rowstart
            for i in range(rowend,rowstart-1,-1):
                ans.append(matrix[i][colstart])
                c += 1
            colstart += 1

        return ans


            
             