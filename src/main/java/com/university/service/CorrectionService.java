package com.university.service;

import com.university.model.Correction;

import java.util.List;

public interface CorrectionService {
    int submitCorrection(Correction correction);
    List<Correction> getAllCorrections();
    List<Correction> getCorrectionsByStatus(String status);
    Correction getCorrectionById(Integer id);
    boolean approveCorrection(Integer id);
    boolean rejectCorrection(Integer id);
}