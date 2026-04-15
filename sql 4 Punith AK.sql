use quality_defect_reduction;
SELECT *
FROM (
    SELECT 
        MachineID,
        Plant,
        AVG(DefectCount / ProductionUnits) AS AvgDefectRate,
        AVG(Temperature) AS AvgTemperature,
        AVG(Vibration) AS AvgVibration,
        AVG(Pressure) AS AvgPressure,
        
        PERCENT_RANK() OVER (
            PARTITION BY Plant 
            ORDER BY AVG(DefectCount / ProductionUnits) DESC
        ) AS defect_rank
        
    FROM quality_defect_reduction
    GROUP BY MachineID, Plant
) ranked_data
WHERE defect_rank <= 0.10;
