"""Synthetic figure routing checks; does not reproduce research datasets."""
import os
import runpy
import shutil
import tempfile
import unittest
from pathlib import Path

import matplotlib
matplotlib.use('Agg')
from matplotlib import pyplot as plt
import numpy as np
import scipy.io


class FigureEntryTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.root = Path(self.temp.name)
        source = Path(__file__).resolve().parents[1]
        self.directories = [
            'ReplyCodes/Fig1code', 'NumericalResults/WavepacketDynamics']
        for directory in self.directories:
            target = self.root / directory
            target.mkdir(parents=True)
            for name in ['Fig1Plot.py', 'Fig1Plot1.py', 'Fig1Plot4.py']:
                shutil.copyfile(source / directory / name, target / name)
            array = np.full((4, 2), 0.25)
            for name, variable in [('psialleff.mat', 'psiall'),
                                   ('psiallrea.mat', 'psiallb'),
                                   ('psiallrea_1.mat', 'psiall'),
                                   ('psiallrea_2.mat', 'psiall')]:
                scipy.io.savemat(target / name, {variable: array})
            for name in ['EVIpr_plot.png', 'N.png', 'plot.png']:
                plt.imsave(target / name, np.ones((3, 3, 3)))
        self.previous_directory = Path.cwd()
        self.unrelated = self.root / 'unrelated'
        self.unrelated.mkdir()
        os.chdir(self.unrelated)

    def tearDown(self):
        plt.close('all')
        os.chdir(self.previous_directory)
        self.temp.cleanup()

    def test_mat_inputs_and_plot_output_follow_both_entry_points(self):
        for directory in self.directories:
            target = self.root / directory
            (target / 'plot.png').unlink()
            runpy.run_path(str(target / 'Fig1Plot.py'), run_name='__main__')
            runpy.run_path(str(target / 'Fig1Plot1.py'), run_name='__main__')
            self.assertTrue((target / 'plot.png').is_file())
            self.assertFalse((self.unrelated / 'plot.png').exists())
            plt.close('all')

    def test_composite_reads_adjacent_images_and_saves_adjacent_output(self):
        for directory in self.directories:
            target = self.root / directory
            runpy.run_path(str(target / 'Fig1Plot4.py'), run_name='__main__')
            self.assertTrue((target / 'merged_output.png').is_file())
            self.assertFalse((self.unrelated / 'merged_output.png').exists())
            plt.close('all')


if __name__ == '__main__':
    unittest.main()

