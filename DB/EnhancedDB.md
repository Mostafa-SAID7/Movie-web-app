## Advanced Query Examples

. Add complex queries that showcase SQL Server's capabilities:

-- Top-rated movies
```
SELECT mov_title, AVG(rev_stars) AS avg_rating
FROM movie
JOIN rating ON movie.mov_id = rating.mov_id
GROUP BY mov_title
ORDER BY avg_rating DESC;
```
-- Movies by Actor
```
SELECT a.act_fname + ' ' + a.act_lname AS actor, m.mov_title
FROM actor a
JOIN movie_cast mc ON a.act_id = mc.act_id
JOIN movie m ON mc.mov_id = m.mov_id
ORDER BY actor;
```
## 🛠️ Indexes and Performance Optimization

-- Add index for faster joins on foreign keys
```
CREATE INDEX idx_movie_cast_actid ON movie_cast(act_id);
CREATE INDEX idx_rating_mov_id ON rating(mov_id);
```
## 🔒 Security and Roles

. Add access controls:

-- Create a read-only user
```
CREATE LOGIN movie_reader WITH PASSWORD = 'StrongPassword123';
CREATE USER movie_reader FOR LOGIN movie_reader;
EXEC sp_addrolemember 'db_datareader', 'movie_reader';
```
## 🧪 Testing and Validation Queries

. Include consistency checks:

-- Check for orphaned cast entries
```
SELECT * FROM movie_cast
WHERE act_id NOT IN (SELECT act_id FROM actor)
   OR mov_id NOT IN (SELECT mov_id FROM movie);
```
## 📈 Power BI Dashboard Suggestions

Visuals:
- Pie Chart: Genre distribution
- Bar Chart: Average rating per movie
- Table: Movie with cast and director

Filters:
- Genre, Year, Language, Country
