-- Chạy câu lệnh này trước để kiểm tra bảng "cart_product" có bao nhiêu bản ghi trùng
SELECT cart_id, prod_id, COUNT(*)
FROM cart_product
GROUP BY cart_id, prod_id
HAVING COUNT(*) > 1;


-- Chạy câu lệnh này để xóa các bản ghi trùng và chỉ giữ lại 1 bản ghi
WITH duplicates AS (
    SELECT ctid, 
           ROW_NUMBER() OVER (PARTITION BY cart_id, prod_id ORDER BY ctid) AS rnum
    FROM cart_product
)
DELETE FROM cart_product
WHERE ctid IN (
    SELECT ctid
    FROM duplicates
    WHERE rnum > 1
);
