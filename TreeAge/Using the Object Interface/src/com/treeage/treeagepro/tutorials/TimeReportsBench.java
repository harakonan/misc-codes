
package com.treeage.treeagepro.tutorials;

import java.rmi.RemoteException;
import java.util.HashMap;
import java.util.Map;

import com.treeage.treeagepro.oi.AnalysisType;
import com.treeage.treeagepro.oi.Report;
import com.treeage.treeagepro.oi.Tree;
import com.treeage.treeagepro.oi.TreeAgeProApplication;

public class TimeReportsBench {

    private static String sampleTree1 = "/Example Models/Healthcare Training Examples/Example12-Microsimulation.trex";
    private static String sampleTree2 = "/Example Models/Discrete Event Simulation/Osteo DES Model.trex";

    private TreeAgeProApplication app;
    
    private int reportNumber = 1;

    public static void main(String[] args) throws RemoteException {
        new TimeReportsBench();
    }

    private TimeReportsBench() throws RemoteException {
        app = new TreeAgeProApplication();
        testTree(sampleTree1);
        testTree(sampleTree2);
    }
    
    private void testTree(String path) throws RemoteException {
        Tree sampleTree = app.getTree(path);
        analyzeTree(sampleTree);
        app.refreshWorkspace();
    }

    private void analyzeTree(Tree myTree) throws RemoteException {
        System.out.println();
        System.out.println(myTree.getFileName());
        runSuite(myTree, 0, 100*100);
        runSuite(myTree, 100, 100);
    }
    
    /**
     *  Runs two analysis with and without time reports.
     */
    private void runSuite(Tree myTree, int samples, int trials) throws RemoteException {
        Map<String, String> params = new HashMap<String, String>();
        params.put("samples", Integer.toString(samples));
        params.put("trials", Integer.toString(trials));
        System.out.printf("%d Samples, %d Trials\n", samples, trials);
        
        params.put("timeEvents", "false");
        Report report = myTree.runAnalysis(AnalysisType.monteCarlo, params, myTree.getRoot());
        long time1 = report.getCalcTime();
        System.out.printf("Simulation complete. Calc time: %.3f s. (100%%), Status: %s\n", time1/1000.0, report.getStatus());
        saveReport(report, "Using the Object Interface/RPTX/Report_" + (reportNumber++) + ".rptx");
        
        params.put("timeEvents", "true");
        report = myTree.runAnalysis(AnalysisType.monteCarlo, params, myTree.getRoot());
        long time2 = report.getCalcTime();
        System.out.printf("Simulation complete. Calc time: %.3f s. (%d%%), Status: %s\n", time2/1000.0, time2*100/time1, report.getStatus());
        saveReport(report, "Using the Object Interface/RPTX/Report_" + (reportNumber++) + ".rptx");
    }
    
    private void saveReport(Report report, String filename) {
        Map<String, String> reportParams = new HashMap<String, String>();
        reportParams.put(Report.RPTX_FILENAME, filename);
        report.saveAsRptx(reportParams);
    }

}
